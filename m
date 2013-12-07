From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 7 Dec 2013 10:13:44 +0800
Subject: [PATCH 03/10] net: stmmac: Use platform data tied with compatible
 strings
In-Reply-To: <20131206.162633.125107323851595113.davem@davemloft.net>
References: <1386350983-13281-1-git-send-email-wens@csie.org>
 <1386350983-13281-4-git-send-email-wens@csie.org>
 <20131206.162633.125107323851595113.davem@davemloft.net>
Message-ID: <CAGb2v64eeq0v+nZ0gNOVTvWbEuk52DOX-aX0K=jO6tvSun8uCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 7, 2013 at 5:26 AM, David Miller <davem@davemloft.net> wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> Date: Sat,  7 Dec 2013 01:29:36 +0800
>
>> +     device = of_match_device(stmmac_dt_ids, &pdev->dev);
>> +     if (!device)
>> +             return -ENODEV;
>> +
>> +     if (device->data)
>> +         memcpy(plat, device->data, sizeof(*plat));
>> +
>
> Don't invent your own indentation using spaces, this memcpy()
> call is not indented properly, it should be two TABs.

Noted. Will fix.
