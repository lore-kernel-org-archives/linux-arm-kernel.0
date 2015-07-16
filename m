From: will.deacon@arm.com (Will Deacon)
Date: Thu, 16 Jul 2015 19:37:50 +0100
Subject: [PATCH] arm64: enable more compressed Image formats
In-Reply-To: <1437069852-8393-1-git-send-email-olof@lixom.net>
References: <1437069852-8393-1-git-send-email-olof@lixom.net>
Message-ID: <20150716183750.GW26390@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Thu, Jul 16, 2015 at 07:04:12PM +0100, Olof Johansson wrote:
> Plumb up Makefile arguments for the already supported formats in the kbuild
> system: lz4, bzip2, lzma, and lzo.
> 
> Note that just as with Image.gz, these images are not self-decompressing and
> the booting firmware still needs to handle decompression before launching the
> kernel image.

No conceptual issues with this, but it breaks my build:

  arch/arm64/Makefile:61: *** mixed implicit and normal rules: deprecated syntax
  arch/arm64/Makefile:61: *** mixed implicit and normal rules: deprecated syntax
  arch/arm64/Makefile:61: *** mixed implicit and normal rules: deprecated syntax
  arch/arm64/Makefile:61: *** mixed implicit and normal rules: deprecated syntax
  make[1]: *** No rule to make target 'Image.gz', needed by 'all'.  Stop.
  make[1]: *** Waiting for unfinished jobs....
  make: *** [sub-make] Error 2

I hear some people run auto-builders nowaways that might spot this ;)

Will
