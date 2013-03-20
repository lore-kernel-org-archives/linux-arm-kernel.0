From: dahuang@nvidia.com (Danny Huang)
Date: Wed, 20 Mar 2013 09:39:17 +0800
Subject: [PATCH] ARM: tegra: fuse: add fuctions to read speedo id and
 process id
In-Reply-To: <5148A8D6.8000002@wwwdotorg.org>
References: <1363660405-10668-1-git-send-email-dahuang@nvidia.com>
 <5148A8D6.8000002@wwwdotorg.org>
Message-ID: <1363743557.3573.50.camel@dahuang-vm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-20 at 02:05 +0800, Stephen Warren wrote:
> On 03/18/2013 08:33 PM, Danny Huang wrote:
> > Add functions to read the speedo and process id of both cpu and soc.
> > There might be some drivers need the information as well.
> 
> What code wants to use these functions? It'd be best to submit this
> patch with that code, so that something actually uses the functions, and
> they don't look like dead code.

There are some developing drivers that are located in drivers folder
needs those information. I think that they can't include a header file
in mach-tegra folder. Hence I'd like to provide them such functions for
their development.
Is there any better way to do this?

> 
> In the past, functions similar to this used to exist. However, they were
> removed and replaced by direct access to the underlying variables. Do we
> actually need functions for this, or can code simply read from the
> variables instead?
