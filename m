From: pku.leo@gmail.com (Leo Li)
Date: Mon, 12 Sep 2016 11:27:13 -0500
Subject: [PATCH v5] i2c: imx: make bus recovery through pinctrl optional
In-Reply-To: <20160912102136.04c0728d@ipc1.ka-ro>
References: <1471644322-22670-1-git-send-email-leoyang.li@nxp.com>
 <20160906185849.27pjhawadca5pwow@pengutronix.de>
 <CADRPPNQ+1qBNL5WA=Jo_keE7BPnoOs7a2T6CpTuciiF16qK6xQ@mail.gmail.com>
 <87ca69fb85848a0a86b34a9a9037a57b@agner.ch>
 <CADRPPNSPye45bmFshfwb+gDA0x0ygs4Ofa6HMYbKt9ER0oeccg@mail.gmail.com>
 <8f8f7ffc4aef513ef5064ba0491fbc63@agner.ch>
 <CADRPPNR4oiRVgFqaM=1=Zn_JzrVJDVmozWsouLByXRtaHCh=qQ@mail.gmail.com>
 <306f579a2f2362595a55c53e48657563@agner.ch>
 <CADRPPNS3PecYRaAMR+0RuzU+gE3y5ZN-x7HzqggrdDsN-CkArg@mail.gmail.com>
 <20160912102136.04c0728d@ipc1.ka-ro>
Message-ID: <CADRPPNQbTCs9TLqUSNUTG6YBn3fs8F6FKUw1G582D4ExcL1oVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 3:21 AM, Lothar Wa?mann <LW@karo-electronics.de> wrote:
> Hi,
>
> On Fri, 9 Sep 2016 14:37:12 -0500 Leo Li wrote:
>> On Fri, Sep 9, 2016 at 11:51 AM, Stefan Agner <stefan@agner.ch> wrote:
>> > On 2016-09-08 16:57, Leo Li wrote:
> [...]
>> >> people fix problem that they don't really care by deliberately enlarge
>> >> the problem.  That's why we don't panic() on any error we found.  For
>> >> those who do care about the bus recovery, they can get the information
>> >> from the console.
>> >
>> > IMHO, it is just stupid to ignore errors and then let the developer
>> > later on trace back what the initial issue was. Error out early is a
>> > common sense software design principle...
>> >
>> > I am not asking for a panic(), I am just suggesting to only ignore
>> > pinctrl if it returns -ENODEV, the case you care are about.
>>
>> It was just an analogy for enlarging the problem for getting
>> attention.  But you probably thought that it was not enlarging the
>> problem as you think pinctrl is required by the driver instead of an
>> optional thing.
>>
> The I2C bus recovery is a feature which is not used during normal
> operation and you won't find that it's not working unless something
> unusual happens (probably only in a productive environment). It may even
> be hard to trigger a condition to test the feature.
> Thus IMO it is vital that the driver complains loudly if something is
> missing to make this feature work if requested.

I agree.  A message is already added in this patch to mention that bus
recovery is not supported due to pinctrl when there is a problem.

Regards,
Leo
