From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 12:05:10 -0600
Subject: [PATCH] ARM: tegra: fuse: add fuctions to read speedo id and
 process id
In-Reply-To: <1363660405-10668-1-git-send-email-dahuang@nvidia.com>
References: <1363660405-10668-1-git-send-email-dahuang@nvidia.com>
Message-ID: <5148A8D6.8000002@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 08:33 PM, Danny Huang wrote:
> Add functions to read the speedo and process id of both cpu and soc.
> There might be some drivers need the information as well.

What code wants to use these functions? It'd be best to submit this
patch with that code, so that something actually uses the functions, and
they don't look like dead code.

In the past, functions similar to this used to exist. However, they were
removed and replaced by direct access to the underlying variables. Do we
actually need functions for this, or can code simply read from the
variables instead?
