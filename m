From: dianders@chromium.org (Doug Anderson)
Date: Mon, 9 Jun 2014 16:57:07 -0700
Subject: [PATCH 0/5] Add Maxim 77802 PMIC support
In-Reply-To: <53963B5D.8090908@collabora.co.uk>
References: <1402306670-17041-1-git-send-email-javier.martinez@collabora.co.uk>
 <1402309011.17650.9.camel@AMDC1943>
 <CAD=FV=U2zPJ=NohDjGvJKfmwJzQhphtVMefM0p_hvFVoReauhQ@mail.gmail.com>
 <53963B5D.8090908@collabora.co.uk>
Message-ID: <CAD=FV=WknbbqSojDD4pe-Xpd6J4LxkjU-O9JwQjU+gnh+6N=4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Mon, Jun 9, 2014 at 3:55 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
>> * The RTC has many subtle differences between the 77686 and 77802.
>> They expanded it to handle a 200 year timeframe instead of 100 and
>> that meant that they had to shuffle the bits around everywhere.  They
>> also moved it to have the same i2c address as the main PMIC so all
>> addresses are different (see max77686_map in the RTC link above).
>>
> There are other differences that were not mentioned:
>
> - The max77802 uses a single register to enable RTC alarm while max77686 uses 1
> bit from a set of registers.

Ironically this is one and the same issue, but you're right that it's
more major than I made it out to be.  See RTCYEARA2.  My theory is
that to account for more possible year values they needed all 8 bits.
That meant that the enable bit needed to move to a different register.
...and once you moved one enable you might as well move them all, I
guess.
