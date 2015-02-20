From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Fri, 20 Feb 2015 01:15:21 -0600
Subject: [RESEND PATCH 2/2] arm: socfpga: Set share override bit of the
 l2 cache controller
In-Reply-To: <CAL_JsqKmbV69Q-hgnvnz-2+2T8k-Q+WcrFmewkfozKk06ZM7OA@mail.gmail.com>
References: <1424365606-19964-1-git-send-email-dinguyen@opensource.altera.com>
 <1424365606-19964-2-git-send-email-dinguyen@opensource.altera.com>
 <CAL_JsqKmbV69Q-hgnvnz-2+2T8k-Q+WcrFmewkfozKk06ZM7OA@mail.gmail.com>
Message-ID: <54E6DF09.9060505@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 2/19/15 12:13 PM, Rob Herring wrote:
> On Thu, Feb 19, 2015 at 11:06 AM,  <dinguyen@opensource.altera.com> wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> By not having bit 22 set in the PL310 Auxiliary Control register (shared
>> attribute override enable) has the side effect of transforming Normal
>> Shared Non-cacheable reads into Cacheable no-allocate reads.
>>
>> Coherent DMA buffers in Linux always have a Cacheable alias via the
>> kernel linear mapping and the processor can speculatively load cache
>> lines into the PL310 controller. With bit 22 cleared, Non-cacheable
>> reads would unexpectedly hit such cache lines leading to buffer
>> corruption.
> 
> You really should be doing this in your bootloader.
> 

Can I ask what is your reasoning for doing this in the bootloader? It's
seems like this is such a nice mechanism to do it here.

Dinh
