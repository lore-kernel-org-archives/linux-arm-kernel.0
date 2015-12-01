From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 1 Dec 2015 22:00:49 +0530
Subject: [PATCH 3/6] net: thunderx: Increase transmit queue length
In-Reply-To: <1448983985.25582.35.camel@edumazet-glaptop2.roam.corp.google.com>
References: <y@samsung.com>
 <1448961223-41888-4-git-send-email-sunil.kovvuri@gmail.com>
 <01d101d12c46$2de43b40$89acb1c0$@samsung.com>
 <1448983985.25582.35.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <CA+sq2Ce9oH-kCDO8hK_wX+ZZdXyyBuT4V2bt5Ab+2=pEX+BO+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel Fedin,

Increasing descriptor ring size will lead to more memory allocation.
And what you are seeing is a memory alloc failure and doesn't seem to
be due to this driver change.
I mean it looks like the behavior will be same for other drivers as well.

Probably you might have to set "coherent_pool" size in bootargs to a
higher value.
Can you please check.

Thanks,
Sunil.

On Tue, Dec 1, 2015 at 9:03 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Tue, 2015-12-01 at 17:40 +0300, Pavel Fedin wrote:
>>  Hello!
>>
>>  This one breaks networking on my machine:
>> --- cut ---
>> swiotlb: coherent allocation failed for device 0002:01:08.4 size=4198400
>> CPU: 2 PID: 3655 Comm: NetworkManager Tainted: G        W  O    4.2.6+ #201
>> Hardware name: Cavium ThunderX CN88XX
>
> Are you sure 4.2.6 kernel is suitable for backporting this patch aimed
> for linux-4.5 ?
>
>
>
