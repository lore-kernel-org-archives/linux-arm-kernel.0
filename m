From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 5 Jun 2013 22:18:28 +0100
Subject: [PATCH] ARM/KVM: save and restore generic timer registers
In-Reply-To: <51AFA992.4060803@linaro.org>
References: <1370039952-20888-1-git-send-email-andre.przywara@linaro.org>
 <20130605192316.GB9640@ubuntu> <51AFA992.4060803@linaro.org>
Message-ID: <CAFEAcA8hp+fWWuvVVLSCxfPdN8itsMq9Jy6jgrcqAJ7bH4zmPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 June 2013 22:11, Andre Przywara <andre.przywara@linaro.org> wrote:
> On 06/05/2013 09:23 PM, Christoffer Dall wrote:
>> To avoid the extra storage overhead here I suggest you just export the
>> registers using a separate number space for the ONE_REG ioctl instead of
>> piggybacking on the cp15 exports.

This is letting the kernel's internal implementation details
affect the userspace API -- I think that's a bad idea.
As Andre says, we went through a round like this, and my
opinion was that since these are cp15 registers the logical
place to put them is in cp15 space.

thanks
-- PMM
