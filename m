From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 9 Dec 2015 10:29:21 +0100
Subject: [linux-sunxi][PATCH 0/2] ARM: dts: sun4i: mk802 variant patches
In-Reply-To: <1449600534-5098-1-git-send-email-codekipper@gmail.com>
References: <1449600534-5098-1-git-send-email-codekipper@gmail.com>
Message-ID: <5667F471.1090505@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marcus,

On 08-12-15 19:48, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> This patch series splits the mk802 dts into common include file which
> can be shared with the mk802+ device. The only difference that I can
> see between this and the original device is that it has an internal
> microphone.
>
> With that in mind we can either leave things as they are and enable
> the capture to the original mk802 dts or apply this patch to distinguish
> between the two devices.

Thanks for your work on this, but I do not think that it is a good idea
to differentiate between the different mk802 (not mk802-ii) models, there
are many variants and the chances of a user knowing exactly which variant
he has are small.

So instead we should do the same as with the q8 formfactor tablets and
strive to have a single dts which works everywhere. Here that seems
easy enough, just always enable the mic input (once we have support for
it), this will give people without the mic just noise if they try to use
it but that is not a big deal IMHO.

Regards,

Hans
