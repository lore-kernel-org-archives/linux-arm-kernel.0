From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Mar 2015 11:36:48 +0000
Subject: [PATCH] ARM: force linker to use PIC veneers
In-Reply-To: <20150325104603.GA3560@e103592.cambridge.arm.com>
References: <1427192184-31261-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150324122239.GB3579@e103592.cambridge.arm.com>
 <CAKv+Gu-MpvAnkEd2L_OPGpDv5cnCZACvzuQ9LbG8O5kjDRQUwQ@mail.gmail.com>
 <20150324135439.GC3579@e103592.cambridge.arm.com>
 <CAKv+Gu9NeqOTjUux9S7p5o89T1tc9ACraC0D53Y=CCTNzZXKMg@mail.gmail.com>
 <20150325104603.GA3560@e103592.cambridge.arm.com>
Message-ID: <20150326113648.GC8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 10:46:14AM +0000, Dave Martin wrote:
> Hmmm, you seem to be right.
> 
> Thumb has no bx <label> instruction, and veneers introduced by ld are
> always ARM code, so this looks tricky to avoid without patching ld.
> 
> As you observe, this only impacts large kernels anyway.
> 
> So,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

Someone needs to check what the result is like for older CPUs too.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
