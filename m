From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Tue, 25 Sep 2012 17:40:07 +0200
Subject: [PATCH v2] hvc_dcc : add support to armv4 and armv5 core
In-Reply-To: <5040EAF7.9010003@codeaurora.org>
References: <1346413645-4593-1-git-send-email-castet.matthieu@free.fr>
 <5040EAF7.9010003@codeaurora.org>
Message-ID: <5061D057.9000308@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Boyd a ?crit :
> On 8/31/2012 4:47 AM, Matthieu CASTET wrote:
>> Signed-off-by: Matthieu Castet <matthieu.castet@parrot.com>
> 
> Please consider adding some sort of commit text. Does this add some new
> feature I may want on some downstream distro kernel?
> 
ok
> 
> It's unfortunate that the main logic is duplicated. I wonder if we could
> push the runtime decision slightly lower into the accessor functions
> instead and make some new functions dcc_tx_busy() and dcc_rx_busy() or
> something. Then these loops stay the same.
see my previous mail

>> +static inline char __dcc_getchar(void)
>> +{
>> +	char c;
>> +
>> +	asm __volatile__ ("mrc p14, 0, %0, c1, c0	@ read comms data reg"
>> +		: "=r" (c));
>> +
> 
> Do you see any multiple character inputs? I think you may need an isb
> here similar to the v6/7 code and in the putchar as well.
I don't see multiple character.
On armv5 isb is only a memory barrier (__asm__ __volatile__ ("" : : : "memory"))
 and it may be not need for dcc operation.


Matthieu
