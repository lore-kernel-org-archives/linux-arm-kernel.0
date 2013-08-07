From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Aug 2013 15:46:28 +0100
Subject: [alsa-devel] [PATCH 1/3] ASoC: bt-sco: enable OF support
In-Reply-To: <CAGsJ_4xhkdNTKr6KBPMMPVfi7+NP+WHq2+_V545An6J+c6E7ug@mail.gmail.com>
References: <1374041536-27643-1-git-send-email-Baohua.Song@csr.com>
 <20130717084039.GA15981@e106331-lin.cambridge.arm.com>
 <20130717094718.GE22506@sirena.org.uk>
 <CAGsJ_4w3fS=vzZmeJOxhKO1TdL9d6pgbrjtzfPugOSOprLV+nw@mail.gmail.com>
 <20130806170430.GL6427@sirena.org.uk>
 <CAGsJ_4xhkdNTKr6KBPMMPVfi7+NP+WHq2+_V545An6J+c6E7ug@mail.gmail.com>
Message-ID: <20130807144628.GC6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 03:59:46PM +0800, Barry Song wrote:

> For 1, what kind of codes will have in the codec driver if adding a
> link to UART in codec dts node? UART is very generic to transfer path.
> it even doesn't know bluetooth is running on top of it.

> For 2, if the case is that we add codec subnode in UART node,  the
> UART driver will need to walk child nodes and extend platform device
> for them, it seems it is not uart driver likes.

I don't know what 1 and 2 are (they weren't numbered in the mail you're
replying to)...  I'd expect that any intelligence would go into
frameworks or into the device for the BT so for example if the BT device
was hanging off the UART then the kernel would have generic support for
parsing the DT and knowing that a fixed device was connected to the UART
and be able to handle that - AIUI line disciplines are often used for
this stuff.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130807/da61f05a/attachment.sig>
