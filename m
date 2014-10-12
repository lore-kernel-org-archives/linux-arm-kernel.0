From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 12 Oct 2014 21:00:52 +0200
Subject: [RFC 6/7] ARM: vf610m4: HACK: get dtb pointer from SRC_GPR3
In-Reply-To: <2bdc44912522eb02db2e4612738fe9f0545b36d9.1413136383.git.stefan@agner.ch>
References: <cover.1413136383.git.stefan@agner.ch>
 <2bdc44912522eb02db2e4612738fe9f0545b36d9.1413136383.git.stefan@agner.ch>
Message-ID: <1815119.sje1JPFb29@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 October 2014 20:14:00 Stefan Agner wrote:
> Get DTB pointer (located in r2) from SRC_GPR3 (argument register
> for secondary core)
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> This is clearly a hack but it works around the need of a boot loader
> on the Cortex-M4. I guess there is no way neither its acceptable to
> do this on machine level..? But then, this can also be done with a
> minimal boot loader loaded just in front of the kernel by the m4boot
> utility.
> 

How do you actually enter the kernel on the m4? Do you use a
decompressor or XIP_KERNEL at the moment? There are probably 
lots of ways to do this, my first idea would be to have a vybrid
specific boot wrapper that consists of just a few assembly
instructions to set up the initial environment from wherever
it gets started.

	Arnd
