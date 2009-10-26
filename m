From: ben@trinity.fluff.org (Ben Dooks)
Date: Mon, 26 Oct 2009 15:31:40 +0000
Subject: S3C6400 SMDK6400 HSMMC problem
In-Reply-To: <20091022172716.2c20c1a8@linpcd55>
References: <20091022172716.2c20c1a8@linpcd55>
Message-ID: <20091026153139.GC8096@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2009 at 05:27:16PM +0200, Markus Schwarzenberg wrote:
> Hello,
> 
> First: i'm new to this list. The new listinfo page tells nothing
> about attachments (are they allowed, size?) or where to put them 
> now - so for now i don't attach two files i actually wanted to 
> provide (my adaptions for u-boot-hsmmc, kernel .config).
> 
> Now the problem: 
> 
> i'm trying to get linux-2.6.32-rc5 working on a Samsung/Meritech 
> SMDK6400, (Processor S3C6400.) 
> 
> The kernel is load sucessfully using u-boot-2009.08-rc3 from the 
> DOS-Partition of a SD Card via the S3C6400 HSMMC 0. 
>   Note1: to get this working I adapted src/cpu/s3c6410/hs_mmc.c 
>          from OpenMoko / qi for u-boot. 
> 
> However the kernel's sdhci driver has problems (I/O errors) using the same
> S3C6400 HSMMC 0 (see below) when trying to mount the root partition from
> the SD Card.

It is possible there is a problem with the setup data being passed for
the system, since the controller has some feedback controls that are
in an extended part of the SDHCI controller space.


-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
