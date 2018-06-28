From: andreyknvl@google.com (Andrey Konovalov)
Date: Thu, 28 Jun 2018 20:29:07 +0200
Subject: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
In-Reply-To: <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180627160800.3dc7f9ee41c0badbf7342520@linux-foundation.org>
Message-ID: <CAAeHK+xz552VNpZxgWwU-hbTqF5_F6YVDw3fSv=4OT8mNrqPzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 1:08 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 26 Jun 2018 15:15:10 +0200 Andrey Konovalov <andreyknvl@google.com> wrote:
>> ====== Benchmarks
>>
>> The following numbers were collected on Odroid C2 board. Both KASAN and
>> KHWASAN were used in inline instrumentation mode.
>>
>> Boot time [1]:
>> * ~1.7 sec for clean kernel
>> * ~5.0 sec for KASAN
>> * ~5.0 sec for KHWASAN
>>
>> Slab memory usage after boot [2]:
>> * ~40 kb for clean kernel
>> * ~105 kb + 1/8th shadow ~= 118 kb for KASAN
>> * ~47 kb + 1/16th shadow ~= 50 kb for KHWASAN
>>
>> Network performance [3]:
>> * 8.33 Gbits/sec for clean kernel
>> * 3.17 Gbits/sec for KASAN
>> * 2.85 Gbits/sec for KHWASAN
>>
>> Note, that KHWASAN (compared to KASAN) doesn't require quarantine.
>>
>> [1] Time before the ext4 driver is initialized.
>> [2] Measured as `cat /proc/meminfo | grep Slab`.
>> [3] Measured as `iperf -s & iperf -c 127.0.0.1 -t 30`.
>
> The above doesn't actually demonstrate the whole point of the
> patchset: to reduce KASAN's very high memory consumption?

You mean that memory usage numbers collected after boot don't give a
representative picture of actual memory consumption on real workloads?

What kind of memory consumption testing would you like to see?
