From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 04 Apr 2013 15:55:01 +0200
Subject: [PATCH] arm: mvebu: Fix the memory size on the Mirabox
In-Reply-To: <20130329193716.GA7127@localhost>
References: <1364579477-19018-1-git-send-email-ryan@presslab.us>
 <20130329180447.GK13280@titan.lakedaemon.net>
 <CABx3TkVK86b8Ku4EvUVe8OBtprwKW6YtJ7OU6YVHa3Bd5s7DsQ@mail.gmail.com>
 <20130329193716.GA7127@localhost>
Message-ID: <515D8635.4080903@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 08:37 PM, Ezequiel Garcia wrote:
> On Fri, Mar 29, 2013 at 11:09:23AM -0700, Ryan Press wrote:
>> Hi Jason,
>>
>> On Fri, Mar 29, 2013 at 11:04 AM, Jason Cooper <jason@lakedaemon.net> wrote:
>>> On Fri, Mar 29, 2013 at 10:51:17AM -0700, Ryan Press wrote:
>>>> The memory size in the device tree is only 512 MB, but the
>>>> Mirabox actually has 1 GB.
>>>>
>>>> Tested the change with memtester and no problems found.
>>>>
>>>> Signed-off-by: Ryan Press <ryan@presslab.us>
>>>> ---
>>>>  arch/arm/boot/dts/armada-370-mirabox.dts | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> Thanks for the patch.  It looks good, but please don't forget to Cc: the
>>> maintainers (Andrew Lunn, Gregory Clemente, and myself).  I almost
>>> missed this one. :)
>>>
> 
> As far as I can remember, Gregory has a Mirabox with only 512 MiB,
> which means some boards were shipped with 512 MiB and some with 1 GiB.
> Moreover, apparently nothing can distinguish one from the other.
> 
> @Gregory: can you confirm this?

I saw that you eventually found a solution, but just in case you still
wait for my answer: I confirm that my board have only 512MiB (according to
U-Boot)

> 
> If Gregory confirms this, then we shouldn't apply this patch.
> Don't forget in-kernel DTS are only meant for developers and
> for reference. The vendor (Globalscale in this case) has to ship
> a proper DTS for each board.
> 
>>> thx,
>>>
>>> Jason.
>>
>> Okay I didn't know I needed to do that.  Thanks!
>>
> 
> Although it's not mandatory, you can do a 'git blame' on the file you're
> patching and find out who should you put on Cc.
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
