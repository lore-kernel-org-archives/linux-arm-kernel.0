From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 5 Sep 2013 18:54:56 +0200
Subject: [PATCH] ASoC: kirkwood: change the compatible string of the
 kirkwood-i2s driver
In-Reply-To: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1378385791-29551-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130905185456.175f556b@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  5 Sep 2013 14:56:31 +0200
Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> The compatible string of the kirkwood-i2s driver was chosen as
> "marvell,mvebu-audio". Using such a compatible string is not a good
> idea, since "mvebu" is the name of a large family of SOCs, in which
> new, unknown SOCs will be coming in the future. It is therefore
> impossible to know what will be evolutions of this hardware block in
> the next generations of the SOCs. For this reason, the recommandation
> for compatible strings of on-SOCs devices has always been to use the
> name of the oldest SOC that has the hardware block. New SOCs that have
> an exactly compatible hardware block can reference it using the same
> compatible string. See [1], [2] and [3] for various cases were this
> suggestion was made, including from Rob Herring, a Device Tree binding
> maintainer.
> 
> As an example, there are already small differences between current
> generations:
> 
>  * On Kirkwood, only one interrupt is used for audio.
>  * On Dove, two interrupts are used, one for audio data and one for
>    error reporting.
> 
> In the near future, I'll be adding audio support to Armada 370, which
> allows has the same hardware block (but maybe with minor variants).
> 
> Therefore, this patch changes the driver to accept
> "marvell,kirkwood-audio" and "marvell,dove-audio" as compatible
> strings instead of the too-generic "marvell,mvebu-audio". The reason
> for the two different compatible strings is the difference in the
> number of interrupts used by the two SOCs for audio.
> 
> This Device Tree binding has never been part of a Linux kernel stable
> release so far, so it can be changed now without breaking backward
> compatibility.
> 
> [1] http://lists.infradead.org/pipermail/linux-mtd/2012-March/040417.html
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-April/161065.html
> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-March/087702.html
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---

The name of the kirwood audio driver has been changed from
"kirkwood-i2s" to "mvebu-audio" by Russell King
(http://www.spinics.net/lists/arm-kernel/msg264185.html).
I have just used this name in the DT.

Then, the second interrupt in Dove is not used in the driver. If it
should, it would be present in the DTs of the dove boards only, so,
actually, there is not need to have different compatibles.

Eventually, you are talking about some other mvebu SoCs. Before adding
any new compatible, it would be nice to know if, for example, some
changes are needed in the kirkwood/dove audio driver for the Armada 370...

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
