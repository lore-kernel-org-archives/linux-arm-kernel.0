From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 6 Dec 2013 14:38:27 +0100
Subject: [PATCH 1/3] arm64: add EFI stub
In-Reply-To: <1386336870.1861.155.camel@deneb.redhat.com>
References: <1385762712-17043-1-git-send-email-msalter@redhat.com>
 <1385762712-17043-2-git-send-email-msalter@redhat.com>
 <20131205141853.GA974@darko.cambridge.arm.com>
 <1386254603.1861.120.camel@deneb.redhat.com>
 <20131205152806.GC974@darko.cambridge.arm.com>
 <20131206122511.301D6C40757@trevor.secretlab.ca>
 <1386336870.1861.155.camel@deneb.redhat.com>
Message-ID: <20131206133827.GB24997@rocoto.smurfnet.nu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 08:34:30AM -0500, Mark Salter wrote:
> > Or just disable runtime services on the switch to big ending. Big endian
> > should not disable the stub (but getting it to work could be a follow-up
> > patch)
> > 
> The other problem with BE is that the PE/COFF masquerading is built into
> head.S so the same Image can be used for EFI and non-EFI. I don't see
> a BE opcode which we could us to provide the magic "MZ" at the start
> of a BE kernel Image.

That's actually not an issue.
Instructions are always LE - endinaness affects only data.

/
    Leif
