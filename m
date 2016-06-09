From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 09 Jun 2016 09:07:08 +0200
Subject: [PATCH] cpufreq: mvebu: fix integer to pointer cast
In-Reply-To: <d3c117ea-2dce-63a2-7888-31ee8320a3dd@codethink.co.uk>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
 <5757CF9B.3080402@free.fr>
 <d3c117ea-2dce-63a2-7888-31ee8320a3dd@codethink.co.uk>
Message-ID: <32804824.nq0AOIbNnC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 8, 2016 9:59:26 AM CEST Ben Dooks wrote:
> On 08/06/16 08:56, Mason wrote:
> > On 07/06/2016 13:30, Ben Dooks wrote:
> > 
> >> Fix the use of 0 instead of NULL to clk_get() call. This stops the
> >> following warning:
> >>
> >> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
> > 
> > May I ask which compiler/version produced that diagnostic?
> 
> I was running with "make C=2 bzImage" for ARM multi_v7_config
> 
> $ sparse --version
> v0.5.0
> 

I believe gcc-6 will also produce a similar warning when building with
'make W=1'. I've started looking into moving some of the warnings from
W=1 level to default, which can probably be done with relatively little
effort for many warnings.

I see that you are making very good progress at eliminating the
-Wmissing-declarations warnings, which are also at W=1 level. Do
you have an estimate of how many there are? Do you plan to do them
all, or just the ones for some subsystems? I've stayed away from
this one for now since there are lots of such warnings, but it
seems particularly worthwhile.

	Arnd
