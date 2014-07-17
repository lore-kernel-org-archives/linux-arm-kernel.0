From: m.smarduch@samsung.com (Mario Smarduch)
Date: Thu, 17 Jul 2014 09:00:46 -0700
Subject: [RESEND PATCH v7 3/4] arm: dirty log write protect management
 support
In-Reply-To: <53B6D66B.9070608@redhat.com>
References: <1401837567-5527-1-git-send-email-m.smarduch@samsung.com>
 <1402076021-9425-1-git-send-email-m.smarduch@samsung.com>
 <20140608120522.GG3279@lvm> <539663A0.9080507@samsung.com>
 <20140610092240.GF1388@lvm> <53974998.70001@samsung.com>
 <20140611070352.GC24286@lvm> <53A0EE60.6030508@samsung.com>
 <20140703150401.GE20104@cbox> <53B6D66B.9070608@redhat.com>
Message-ID: <53C7F32E.2030307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2014 09:29 AM, Paolo Bonzini wrote:
> Il 03/07/2014 17:04, Christoffer Dall ha scritto:
>> Hmmm, I'm really not an expert in the 'established procedures' for what
>> to put in config files etc., but here's my basic take:
>>
>> a) you wouldn't put a config option in Kconfig unless it's comething
>> that's actually configurable or some generic feature/subsystem that
>> should only be enabled if hardware has certain capabilities or other
>> config options enabled.
>>
>> b) this seems entirely an implementation issue and not depending on
>> anything users should select.
> 
> Actually I think Mario's idea is just fine.  Non-user-accessible Kconfig
> symbols are used a lot to invoke an #ifdef elsewhere in the code;
> compare this with his proposal is a bit different but not too much.
> 
> Sometimes #defines are used, sometimes Kconfig symbols, but the idea is
> the same.
> 
> Paolo

Hi Paolo,
  thanks for your feedback. I forgot to add that I tried define 
ARCH_HAVE_... approach but checkpatch rejected it and insisted
on Kconfig.

Thanks,
- Mario
