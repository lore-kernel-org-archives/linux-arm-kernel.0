From: carmelo.amoroso@st.com (Carmelo AMOROSO)
Date: Thu, 6 Jan 2011 15:16:25 +0100
Subject: [PATCH 1/2] stackprotector: add stack smashing protector
	generic implementation
In-Reply-To: <20110106093940.GA31708@n2100.arm.linux.org.uk>
References: <1293111851-7175-1-git-send-email-filippo.arcidiacono@st.com>
	<4D245D16.5010702@st.com>
	<20110106093940.GA31708@n2100.arm.linux.org.uk>
Message-ID: <4D25CEB9.7090205@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/6/2011 10:39 AM, Russell King - ARM Linux wrote:
> On Wed, Jan 05, 2011 at 12:59:18PM +0100, Carmelo AMOROSO wrote:
>  > Is someone interested into this stuff ?
> 
> Looking at the CC list, you're asking the people who already have the
> support in the kernel. I suspect they don't have that much of an
> interest in it.
> 
> Maybe you should try asking other architecture maintainers who don't
> support this yet? Not every architecture maintainer is subscribed to,
> or reads LKML...
> 

Hi Russel, thanks for your feedback.
Well, SH (in CC) does not have this support. Indeed we posted it
initially to linux-sh only. We got useful feedback from Paul, Mike and
Nicolas suggesting to promote the ARM/SH solution based on the global
__stack_chk_guard variable as a generic solution for all other
architectures. This is why I thought to post to the LKML instead of each
linux-<arch> list.
The code is able to detect if the arch implementation is based on the
global (if so the generic implementation should work cleanly), otherwise
it will fail to compile when trying to include the
linux/asm/stackprotector.h. This is an easy way to detect the lack of an
arch specific implementation (but likely only x86 needs it... I don't know).

So the idea is to use the ARM code as generic's one (tested on SH
kernel). Mike Frysinger volunteered to try on blackfin for example.

cheers
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk0lzrkACgkQoRq/3BrK1s/JhACdERr4TFBaGmf4XuQEUA/9X/Kt
lz4An0fctncE+n9fhHvvZEbIZEilJKNO
=5yFm
-----END PGP SIGNATURE-----
