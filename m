From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 28 Feb 2018 23:44:18 +0530
Subject: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
In-Reply-To: <d9e14058-6ffb-e54a-1565-f228342ee1f0@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
 <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com>
 <d9e14058-6ffb-e54a-1565-f228342ee1f0@sholland.org>
Message-ID: <CABb+yY3nfVxoA9wy1ym4mtCTKCZtJjepUTr7OP1uUPmzOEzniA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 11:21 PM, Samuel Holland <samuel@sholland.org> wrote:
> Hi,
>
> On 02/28/18 03:16, Jassi Brar wrote:
>> On Wed, Feb 28, 2018 at 7:57 AM, Samuel Holland <samuel@sholland.org> wrote:
>> ....
>>
>>> +/*
>>> + * The message box hardware provides 8 unidirectional channels. As the mailbox
>>> + * framework expects them to be bidirectional
>>>
>> That is incorrect. Mailbox framework does not require a channel to be
>> TX and RX capable.
>
> Sorry, it would be more accurate to say that the intended mailbox _client_
> expects the channels to be bidirectional.
>
Mailbox clients are very mailbox provider specific. Your client driver
is unlikely to be reuseable over another controller+remote combo.
Your client has to know already what a physical channel can do (RX, TX
or RXTX). There is no api to provide that info.

thanks
