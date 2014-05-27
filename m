From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 May 2014 20:49:32 +0100
Subject: [PATCH v3 0/6] mfd: axp20x: add AXP221 PMIC support
In-Reply-To: <1401183535-31003-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1401183535-31003-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140527194932.GD12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 27, 2014 at 11:38:49AM +0200, Boris BREZILLON wrote:

> I'm still waiting for inputs regarding the ipsout regulator representation:

If you've got questions you need an answer to urgently it's possibly
best to highlight them outside of a series like this doing that helps
make it more obvious.

>  * The ipsout regulator is currently represented as a fixed regulator
>    providing a 5v output, and this is not exactly the case.
>    AFAIU (here's is the datasheet traduction if you want to check [1]), the
>    ipsout output is a multiplexer that choose among vbus (5V), acin (12V
>    which is then converted to 5V) and the battery power supply (3,5 -> 4,2 V).
>    This means the output voltage of ipsout vary between 3,5V and 5V.
>    How can we express this kind of muxer in the regulator framework (is there
>    already something available ?) ?
>    Note that the power supply selection is automatic, though we could force
>    one power supply, but then we loose the ability to unplug one power supply
>    without impacting the system.

This sounds like it may as well just be represented as an unregulated
supply - it's just the system root supply really.  Nothing can rely on
the voltage anyway as it's going to vary randomly depending on what the
user does power wise and typically it'd only be used as a supply for
things that don't care about the specific voltage.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140527/0a89a4cc/attachment.sig>
