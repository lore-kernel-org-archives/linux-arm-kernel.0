From: lars@metafoo.de (Lars-Peter Clausen)
Date: Sat, 23 Mar 2013 11:07:16 +0100
Subject: [PATCH v3] clk: add si5351 i2c common clock driver
In-Reply-To: <514B7C80.2070008@gmail.com>
References: <1360414772-12232-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1363603397-2762-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <514B4CBF.7070106@metafoo.de> <514B7C80.2070008@gmail.com>
Message-ID: <514D7ED4.2030205@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/21/2013 10:32 PM, Sebastian Hesselbarth wrote:
>>> +
>>> +    dev_info(&client->dev, "registered si5351 i2c client\n");
>>> +
>>
>> That's just noise, imagine every driver would print such a line, your bootlog
>> would be scrolling for hours ;) I'd either remove it or make it dev_dbg
> 
> Actually, I understand not to have it, but if you don't want it you can still
> boot with "quiet", can't you? Having one single line that helps you see it has
> been probed helps a lot. But, I don't have a strong opinion on that and can
> make it dev_dbg.

It is useful during development, but in my opinion only as long as not every
other driver does this as well. If you want to check whether a device has
been probed you can easily do this by checking the drivers sysfs node.

- Lars
