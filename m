From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 19 Jun 2017 10:27:33 -0700
Subject: [PATCH v3 2/4] asm-generic: Provide a fncpy() implementation
In-Reply-To: <20170619151818.pvjygbdvm6arvarq@yury-thinkpad>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170617000744.22158-3-f.fainelli@gmail.com>
 <20170618235108.peaxdi367jpkt542@yury-thinkpad>
 <20170619151818.pvjygbdvm6arvarq@yury-thinkpad>
Message-ID: <f9839beb-ea66-18c3-c541-b78080b560b3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2017 08:18 AM, Yury Norov wrote:
> On Mon, Jun 19, 2017 at 02:51:08AM +0300, Yury Norov wrote:
>> Hi Florian,
>>
>> Some questions and thoughts inline.
>>
>> Yury
>>
>> On Fri, Jun 16, 2017 at 05:07:42PM -0700, Florian Fainelli wrote:
>>> Define a generic fncpy() implementation largely based on the ARM version
>>> that requires an 8 bytes alignment for the destination address where to
>>> copy this function as well as the function's own address.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>> ---
>>>  include/asm-generic/fncpy.h | 93 +++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 93 insertions(+)
>>>  create mode 100644 include/asm-generic/fncpy.h
> 
> One else thing I forgot to ask - now you have the generic
> implementation for fncpy(), so do you really need to save arm
> version of it?

Yes, it needs to deal with the Thumb bit, and there is no point in
making the generic implementation extremely flexible to support that
special case.

Thanks
-- 
Florian
