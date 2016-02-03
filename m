From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2016 00:03:51 +0000
Subject: [PATCH 1/3] ARM: move .vectors and .stubs sections back into the
 kernel VMA
In-Reply-To: <1454419174-21290-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
 <1454419174-21290-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160203000351.GX10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 02:19:32PM +0100, Ard Biesheuvel wrote:
> The sections themselves are emitted 4 KB apart, as required:
>   ...
>   [16] .stubs       PROGBITS   c0c35000 a35000 0002c0 00  AX  0   0 32
>   [17] .vectors     PROGBITS   c0c34000 a44000 000020 00  AX  0   0  2
>   ...

... which means we end up wasting most of a page for absolutely no
purpose what so ever.  Sorry, I'm really not happy about this
gratuitous wastage.

We changed to the existing solution to get rid of the VMA offset
to make the code easier to read, but if we're going to get rid of
that improvement, just revert the change.  (Check the kernel history.)

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
