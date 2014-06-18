From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 18 Jun 2014 11:14:25 -0700
Subject: [PATCH] ARM: zImage: ensure header in LE format for BE8 kernels
In-Reply-To: <CAGa+x85P-M3qUD6L=kezkiQ1NJymEZ9P=u2ANUZJu2b3F+o5LA@mail.gmail.com>
References: <1397147232-28516-1-git-send-email-taras.kondratiuk@linaro.org>
 <CAGa+x85P-M3qUD6L=kezkiQ1NJymEZ9P=u2ANUZJu2b3F+o5LA@mail.gmail.com>
Message-ID: <53A1D701.8060404@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/14 10:55, Kevin Hilman wrote:
>
> All of that to say, with this patch applied, I need a new (and
> reliable) way to determine the endianness of a kernel just by looking
> at the zImage.  Recommendations welcome.

Assuming that you have the .config configured to be built into the
kernel you could use extract-ikconfig

$ ./scripts/extract-ikconfig zImage | grep CONFIG_CPU_ENDIAN_BE8


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
