From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jan 2017 12:03:37 +0100
Subject: [PATCH v14 3/5] tee: add OP-TEE driver
In-Reply-To: <20170125100252.GA8889@kroah.com>
References: <1484744296-30003-1-git-send-email-jens.wiklander@linaro.org>
 <8183743.bSJXZpMh95@wuerfel> <20170123090852.GB1910@jax>
 <5564439.UZohRc66aK@wuerfel>
 <20170124125330.GA30998@jax> <20170125094744.GA7121@jax>
 <20170125100252.GA8889@kroah.com>
Message-ID: <CAK8P3a1OJV4tvE1zxCvpCmXTz8QuxbxivWjkfpPbMQpVikD=Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 11:02 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Jan 25, 2017 at 10:47:45AM +0100, Jens Wiklander wrote:
>> On Tue, Jan 24, 2017 at 01:53:30PM +0100, Jens Wiklander wrote:
>> >
>> > /sys/class/tee/ sounds good, I'll use that. It's more or less what we
>> > also have today.
>>
>> I'm sorry, it seems a struct device has to be used in order to put stuff
>> under /sys/class/tee/. Or am I missing something?
>
> Nope, that is correct.

But that's a different device: this device represents the "class" of
device for the
user space interface, nothing wrong with that. However, we don't need both
the class device and a platform device that is made up by the optee driver
for a firmware feature to represent the same entity that we have the
class device
for.

     Arnd
