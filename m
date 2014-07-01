From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 01 Jul 2014 10:55:37 +0200
Subject: [PATCH v2 07/12] usb: chipidea: add a generic driver
In-Reply-To: <20140701002112.GA26146@shlinux1.ap.freescale.net>
References: <1403606121-6368-1-git-send-email-antoine.tenart@free-electrons.com>
 <1403606121-6368-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140627032506.GA18039@shlinux1.ap.freescale.net>
 <20140630133313.GA11880@kwain>
 <20140701002112.GA26146@shlinux1.ap.freescale.net>
Message-ID: <53B27789.3090509@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 02:21 AM, Peter Chen wrote:
> On Mon, Jun 30, 2014 at 03:33:13PM +0200, Antoine T?nart wrote:
>> On Fri, Jun 27, 2014 at 11:25:07AM +0800, Peter Chen wrote:
>>> On Tue, Jun 24, 2014 at 12:35:16PM +0200, Antoine T?nart wrote:
>>>> +
>>>> +static const struct of_device_id ci_hdrc_generic_of_match[] = {
>>>> +	{ .compatible = "chipidea-usb" },
>>>> +	{ }
>>>> +};
>>>
>>> Even as a generic driver, you can also use your own compatible string.
>>
>> Well, there is nothing specific about the Berlin CI. Some subsystems
>> use the 'generic' keyword in these cases. Do you see a particular reason
>> I should use some Berlin related compatible here?
>
> Not must, one suggestion is: can you change the compatible string
> to "chipidea-usb-generic"?

I don't know about ChipIdea/ARC/DW's product portfolio but I guess
the compatible should also carry '2.0' or 'usb2' in it. Or we just
use some version number like 'chipidea,ci13000' or 'chipidea,ci13xxx'.

Sebastian
