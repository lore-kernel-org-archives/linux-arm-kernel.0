From: keescook@chromium.org (Kees Cook)
Date: Tue, 3 Jan 2017 13:18:29 -0800
Subject: [PATCH] rtc: armada38x: add __ro_after_init to armada38x_rtc_ops
In-Reply-To: <20170102140654.GF14217@n2100.armlinux.org.uk>
References: <1482751862-18699-1-git-send-email-bhumirks@gmail.com>
 <20170102140654.GF14217@n2100.armlinux.org.uk>
Message-ID: <CAGXu5jJLA=GcOhV5Z_6AOGa1KhW7fXtqBGrewEeViaJ9TiE-aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 2, 2017 at 6:06 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Dec 26, 2016 at 05:01:02PM +0530, Bhumika Goyal wrote:
>> The object armada38x_rtc_ops of type rtc_class_ops structure is not
>> modified after getting initialized by armada38x_rtc_probe. Apart from
>> getting referenced in init it is also passed as an argument to the function
>> devm_rtc_device_register but this argument is of type const struct
>> rtc_class_ops *. Therefore add __ro_after_init to its declaration.
>
> What I'd prefer here is for the structure to be duplicated, with one
> copy having the alarm methods and one which does not.  Both can then
> be made "const" (so placed into the read-only section at link time)
> and the probe function select between the two.
>
> I think that's a cleaner and better solution, even though it's
> slightly larger.
>
> I'm not a fan of __ro_after_init being used where other solutions are
> possible.

Can the pointer that points to the struct rtc_class_ops be made ro_after_init?

-Kees

-- 
Kees Cook
Nexus Security
