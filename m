From: joe@perches.com (Joe Perches)
Date: Mon, 30 Mar 2015 10:55:19 -0700
Subject: [PATCH 1/6] clk: make strings in parent name arrays const
In-Reply-To: <1427737245-4064-2-git-send-email-s.hauer@pengutronix.de>
References: <1427737245-4064-1-git-send-email-s.hauer@pengutronix.de>
 <1427737245-4064-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1427738119.14276.19.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-03-30 at 19:40 +0200, Sascha Hauer wrote:
> The clk functions and structs declare the parent_name arrays as
> 'const char **parent_names' which means the parent name strings
> are const, but the array itself is not. Use
> 'const char * const * parent_names' instead which also makes
> the array const. This allows us to put the parent_name arrays into
> the __initconst section.

If these are pointer entries are stored, care needs to be
taken to make sure that the memory isn't discarded or needed
post init.
