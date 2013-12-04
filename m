From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 4 Dec 2013 16:09:13 +0900
Subject: [PATCH v2] ARM: tegra: switch FUSE clock on before usage
In-Reply-To: <528EB4EE.309@nvidia.com>
References: <1385001613-19098-1-git-send-email-acourbot@nvidia.com>
 <528E6D58.6050503@wwwdotorg.org> <528EB4EE.309@nvidia.com>
Message-ID: <CAAVeFuJpHXCANRO=AT5mKGpHzJRpmQoOuX4hjsctEMMAMjgqnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Nov 22, 2013 at 10:35 AM, Alex Courbot <acourbot@nvidia.com> wrote:
> On 11/22/2013 05:30 AM, Stephen Warren wrote:
>>
>> On 11/20/2013 07:40 PM, Alexandre Courbot wrote:
>>>
>>> FUSE clock is enabled by most bootloaders, but we cannot expect it to be
>>> on in all contexts (e.g. kexec).
>>>
>>> Ensure the FUSE clock is enabled before any of its registers is touched.
>>> Since FUSE is touched very early during system boot (before the clock
>>> devices are registered), directly manipulate the clock register bit in
>>> case the clock device cannot be acquired.
>>
>>
>> This looks reasonable to me. I'll apply it soon after -rc1.
>
>
> Thanks. Be careful as I noticed I misformatted my commit message. The part
> after the "--" will not be stripped by git am as I intended it to be. I
> understood what I did wrong and will hopefully not make that mistake again.
>
> Sorry for the inconvenience.

I am not seeing this in your tree, have you applied it somewhere already?
