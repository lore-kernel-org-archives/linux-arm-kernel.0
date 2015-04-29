From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 29 Apr 2015 07:44:02 +0530
Subject: [PATCH 2/3] ARM: bcm2835: Add the Raspberry Pi firmware driver
In-Reply-To: <55403AD1.4030103@wwwdotorg.org>
References: <1430176449-12322-1-git-send-email-eric@anholt.net>
 <1430176449-12322-3-git-send-email-eric@anholt.net>
 <55403AD1.4030103@wwwdotorg.org>
Message-ID: <CABb+yY1Lj9L_aJQRgDuabw0MRVo9Fn6sYt=U0M3SOAQUrjQT0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 7:28 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/27/2015 05:14 PM, Eric Anholt wrote:
>
>> +     firmware->chan = mbox_request_channel(&firmware->cl, 0);
>> +     if (IS_ERR(firmware->chan)) {
>> +             ret = PTR_ERR(firmware->chan);
>> +             /* An -EBUSY from the core means it couldn't find our
>> +              * channel, because the mailbox driver hadn't
>> +              * registered yet.
>> +              */
>> +             if (ret == -EBUSY)
>> +                     ret = -EPROBE_DEFER;
>> +             else
>> +                     dev_err(dev, "Failed to get mbox channel: %d\n", ret);
>
> I would have hoped that mbox_request_channel() returned -EPROBE_DEFER
> itself. It really should...
>
Yes, it should. Let me look into it.

Thanks.
