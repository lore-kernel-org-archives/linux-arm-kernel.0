From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Sat, 21 Mar 2015 21:03:05 -0700
Subject: [PATCH v3] input: Add support for ChipOne icn8318 based
 touchscreens
In-Reply-To: <1426007133-9606-1-git-send-email-hdegoede@redhat.com>
References: <1426007133-9606-1-git-send-email-hdegoede@redhat.com>
Message-ID: <20150322040305.GA40622@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Tue, Mar 10, 2015 at 06:05:33PM +0100, Hans de Goede wrote:
> +	error = devm_request_threaded_irq(dev, client->irq, NULL, icn8318_irq,
> +					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

Shouldn't we let DT data tell us what trigger to use? I.e. just leave
IRQF_ONESHOT here?

No need to resubmit, just let me know if you agree/disagree...

Thanks.

-- 
Dmitry
