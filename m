From: jeffy.chen@rock-chips.com (jeffy)
Date: Thu, 19 Oct 2017 09:54:40 +0800
Subject: [RFC PATCH v4 4/8] drm/rockchip: dw_hdmi: Fix error handling path
In-Reply-To: <20171017181034.tsplfsmq7vi4uhmo@art_vandelay>
References: <20171017101624.12506-1-jeffy.chen@rock-chips.com>
 <20171017101624.12506-5-jeffy.chen@rock-chips.com>
 <20171017181034.tsplfsmq7vi4uhmo@art_vandelay>
Message-ID: <59E805E0.50006@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

Thanks for your review.

On 10/18/2017 02:10 AM, Sean Paul wrote:
> On Tue, Oct 17, 2017 at 06:16:20PM +0800, Jeffy Chen wrote:
>> >Add missing clk_disable_unprepare() in bind()'s error handling path.
> This also isn't disabled in unbind(), is that intentional?
>
i wasn't able to do that because of dw_hdmi drvdata.

i've modified it as tomasz did for dp bridge, and fixed the unbind() in 
the next version :)
