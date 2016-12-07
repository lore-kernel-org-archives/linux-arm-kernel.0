From: philipp.tomsich@theobroma-systems.com (Dr. Philipp Tomsich)
Date: Wed, 7 Dec 2016 12:07:24 +0100
Subject: [Question] New mmap64 syscall?
In-Reply-To: <20161207103451.GA869@yury-N73SV>
References: <20161206185440.GA4654@yury-N73SV> <3014428.VXGdOARdm1@wuerfel>
 <20161207103451.GA869@yury-N73SV>
Message-ID: <0F280FED-870A-42B5-ABC4-1976ACA32462@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Resend, as my mail-client had insisted on using the wrong MIME type?]

> On 07 Dec 2016, at 11:34, Yury Norov <ynorov@caviumnetworks.com> wrote:
> 
>> If there is a use case for larger than 16TB offsets, we should add
>> the call on all architectures, probably using your approach 3. I don't
>> think that we should treat it as anything special for arm64 though.
> 
> From this point of view, 16+TB offset is a matter of 16+TB storage,
> and it's more than real. The other consideration to add it is that
> we have 64-bit support for offsets in syscalls like sys_llseek().
> So mmap64() will simply extend this support.

I believe the question is rather if the 16TB offset is a real use-case for ILP32.  This
seems to bring the discussion full-circle, as this would indicate that 64bit is the 
preferred bit-width for all sizes, offsets, etc. throughout all filesystem-related calls 
(i.e. stat, seek, etc.).

But if that is the case, then we should have gone with 64bit arguments in a single
register for our ILP32 definition on AArch64.

In other words: Why not keep ILP32 simple an ask users that need a 16TB+ offset
to use LP64? It seems much more consistent with the other choices takes so far.

?Phil.
