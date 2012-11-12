From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 12 Nov 2012 10:43:20 +0100
Subject: [PATCH RFT 2/2] pinctrl: dove: Checking valid config in
 dove_audio1_ctrl_set
In-Reply-To: <1352641569.3113.2.camel@phoenix>
References: <1352641495.3113.1.camel@phoenix> <1352641569.3113.2.camel@phoenix>
Message-ID: <50A0C4B8.3000605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2012 02:46 PM, Axel Lin wrote:
> Move the code checking valid config to dove_audio1_ctrl_set(), this ensures we
> always set valid config. And then dove_audio1_ctrl_get() always returns correct
> config.
>
> Signed-off-by: Axel Lin<axel.lin@ingics.com>

Axel,

although correct in a software point-of-view, I don't think we should move this
from _get to _set because the hardware allows to set these bits without changing
the actual function. There are some dominant bits in this settings so the masking
is done to not have ~5 different values for the same function here.

The pinctrl driver will set one of the (software) supported values anyway but on
reset there could be one of the values mentioned above written into the registers.

Sebastian
