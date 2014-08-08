From: sonnyrao@chromium.org (Sonny Rao)
Date: Fri, 8 Aug 2014 10:45:45 -0700
Subject: [PATCH] pinctrl: rockchip: fix rk3288 gpio0 pull up configuration
In-Reply-To: <3160375.WuYbctxldE@diego>
References: <1406690465-11081-1-git-send-email-sonnyrao@chromium.org>
 <CACRpkdZUSziMwd+_uf7dQepQEyG1wQJnV9zkUML=NtLhft4NUQ@mail.gmail.com>
 <3160375.WuYbctxldE@diego>
Message-ID: <CAPz6YkWXHN+DgkkA-00V++SphW8zwASWp25OfcXd8RuNN6_1Kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 8, 2014 at 7:09 AM, Heiko St?bner <heiko@sntech.de> wrote:
> Am Freitag, 8. August 2014, 15:37:46 schrieb Linus Walleij:
>> On Wed, Jul 30, 2014 at 5:21 AM, Sonny Rao <sonnyrao@chromium.org> wrote:
>> > On rk3288, for gpio bank 0, the registers which configure pull-ups
>> > don't implement the enable bits in the upper half of the register,
>> > unlike the other gpio configuration registers, and so the kernel
>> > must perform a read-modify-write of the register to update a
>> > particular gpio's pull up settings in that bank.
>> >
>> > The current code is actually clobbering the contents of the register,
>> > so this fixes it by using regmap_update_bits and masking out only the
>> > bits which require updating.  In the case of gpio0 on rk3288 the upper
>> > enable bits will just get ignored, and the other configurations won't
>> > get clobbered.
>> >
>> > Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
>>
>> Waiting for a v2 fixing the other issues pointed out by Heiko.
>
> Sonny posted v2 on 2014-08-01 as reply to my comment, but it might still be
> sitting in your inbox-backlog :-)
>
> Checking Sonny's v2-mail again I see that you did somehow land in the Cc-list
> and not the To-list, which might be the reason you didn't see it yet?

Yeah, let me know if I'm doing something incorrect with respect to procedure.
I will also re-send to Linus if he needs.

Thanks,
Sonny

>
>
> Heiko
