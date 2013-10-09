From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 9 Oct 2013 21:13:57 +0200
Subject: [GIT PULL] ARM: NEON accelerated AES
In-Reply-To: <20131007162548.GB12030@localhost.localdomain>
References: <1381151998-7936-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131007162548.GB12030@localhost.localdomain>
Message-ID: <CAKv+Gu-49USqKxRGuObtD3eFnQJeU_nNFSroauvJ3eXG1S0MXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 October 2013 18:25, Dave Martin <Dave.Martin@arm.com> wrote:
> On Mon, Oct 07, 2013 at 03:19:58PM +0200, Ard Biesheuvel wrote:
>> !! NOTE !!: this series build-depends on patch a62b01cd (crypto: create generic
>> version of ablk_helper) which is in linux-next but not yet in mainline.
>>
>> The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa94f6:
>>
>>   Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.linaro.org/people/ardbiesheuvel/linux-arm.git arm-aesbs
>>
>> for you to fetch changes up to e4e7f10bfc4069925e99cc4b428c3434e30b6c3f:
>>
>>   ARM: add support for bit sliced AES using NEON instructions (2013-10-04 20:48:38 +0200)
>
> Since nobody has stepped up to review this in detail, it appears there
> may be nobody on the relvant lists who is sufficiently expert in AES and
> NEON/v8 to review it.
>

Well, I did receive (and implemented) a very useful suggestion from
Jussi Kivilinna on the linux-crypto list which resulted in a 25%
speedup in decryption, so some people did actually look at the code in
detail.
Note btw that this is v7 not v8, there is no v8 support yet in
OpenSSL. I have been hitting the list with v8 stuff as well, so I
understand the confusion.

> To trust the openssl community on this doubtless makes sense (I notice
> that, by an astonishing coincidence, the relevant changes to that project
> have been made a certain Ard Biesheuvel).
>
> How do you propose this code should be maintained in the kernel?
>

Well, I tried very hard to make this as little of a burden as possible
by putting all the kernel specific hooks in the upstream codebase. The
bsaes-armv7.pl in this series is identical to the upstream one, and
trying to keep it that way is our best bet imo.

Perhaps the more senior members in this community would like to
comment on how to proceed with keeping this in sync, as I am sure this
is not the first time code has been adopted from another open source
project. How does this work in general?

> Adding a script which automatically diffs the files in the kernel
> against openssl might be a good idea -- not every time the kernel is
> built, but as a maintainer activity someone can script up.  This has the
> advantage that ordinary kernel developers will be able to comprehend,
> review, and use it, unlike the AES code itself.
>
> Otherwise, important upstream fixes may not reach the kernel, or the
> two codebases might diverge, especially if a significant code refactoring
> occurs in openssl.  (I don't know whether that's likely or not)
>

Well, fortunately, the OpenSSL maintainer is very eager to keep his
code in sync, so I am sure he will notify me (and likely the list
and/or Russell as well) if he takes in any fixes. Let's reciprocate
and keep him in the loop if we spot any errors or other issues.

Regards,
Ard.
