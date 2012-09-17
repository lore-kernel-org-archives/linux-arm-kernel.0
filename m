From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 17 Sep 2012 11:41:23 +0300
Subject: [PATCH v3 02/15] dmaengine: omap: Add support for pause/resume
 in cyclic dma mode
In-Reply-To: <1347851637.1943.125.camel@vkoul-udesk3>
References: <1347624358-25582-1-git-send-email-peter.ujfalusi@ti.com>
 <1347624358-25582-3-git-send-email-peter.ujfalusi@ti.com>
 <1347851637.1943.125.camel@vkoul-udesk3>
Message-ID: <5056E233.6010900@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 09/17/2012 06:13 AM, Vinod Koul wrote:
> On Fri, 2012-09-14 at 15:05 +0300, Peter Ujfalusi wrote:
>> -       /* FIXME: not supported by platform private API */
>> -       return -EINVAL;
>> +       /* Pause/Resume only allowed with cyclic mode */
>> +       if (!c->cyclic)
>> +               return -EINVAL; 
> This is not a dma restriction right?

The pause/resume operation has been only used by audio. This might work with
non cyclic modes as well but it has never been used/tested so to be safe I
have added this restriction.

-- 
P?ter
