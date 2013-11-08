From: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 08 Nov 2013 07:09:36 -0800
Subject: [RFC PATCH 0/4] wire up CPU features to udev based module loading
In-Reply-To: <20131107223046.GK1962@tassilo.jf.intel.com>
References: <1383844657-17487-1-git-send-email-ard.biesheuvel@linaro.org>
 <527C0195.50008@zytor.com> <20131107213944.GJ1962@tassilo.jf.intel.com>
 <CAKv+Gu9W-Pu4DGgB-85A3D4Ps9_FLSQgyK3EM7=k7KE1=xsnwg@mail.gmail.com>
 <20131107223046.GK1962@tassilo.jf.intel.com>
Message-ID: <a36043f3-15cc-40a4-9226-70e357ceb4d8@email.android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I assumed he was referring to just dropping those fields of they didn't make sense for the architecture.  That would make sense to do.

Andi Kleen <ak@linux.intel.com> wrote:
>> - the module aliases host tool has no arch specific dependencies at
>> all except having x86cpu as one of the entries: would you mind
>> dropping the x86 prefix there? Or rather add dependencies on $ARCH?
>> (If we drop it there, we basically end up with 'cpu:' everywhere)
>
>Should be fine.
>
>> - in the vendor/family/model case, it may be preferable to drop these
>> fields entirely from certain modules' aliases if they match on 'any'
>> (provided that the module tools permit this) rather than add
>> architecture, variant, revision, etc  fields for all architectures if
>> they can only ever match on one
>
>The module tools require everything matching with the same wild cards.
>
>So I don't know how "any" would work.
>
>-Andi

-- 
Sent from my mobile phone.  Please pardon brevity and lack of formatting.
