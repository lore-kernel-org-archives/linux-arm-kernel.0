From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 2 Jul 2012 12:05:53 +0300
Subject: [PATCH 2/2] remoteproc: remove the now-redundant kref
In-Reply-To: <20120702085911.GA16639@n2100.arm.linux.org.uk>
References: <1338017791-9442-1-git-send-email-ohad@wizery.com>
 <1338017791-9442-2-git-send-email-ohad@wizery.com>
 <4FC5DD74.4030202@codeaurora.org>
 <CAK=WgbbwaMAnTGcivC9ZR8K-MtTqHAV3+BgUmk8WjCaayifJxw@mail.gmail.com>
 <4FCD272E.1020300@codeaurora.org>
 <CAK=WgbZu1hYOd27r259b2v48VFYeOZ4UE5sD2awZDxgBgjAsXw@mail.gmail.com>
 <20120702085911.GA16639@n2100.arm.linux.org.uk>
Message-ID: <CAK=WgbaV2ehq=Y2AFojG6r4HuiGQ+_hEC+azxBJDfrWEi=DTTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 2, 2012 at 11:59 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Jul 02, 2012 at 11:52:27AM +0300, Ohad Ben-Cohen wrote:
>> Simplify the unregister/free interfaces, and make them easier
>> to understand and use, by moving to a symmetric and consistent
>> alloc() -> register() -> unregister() -> free() flow.
>
> The naming in the driver model is:
>
> alloc() -> add() -> del() -> put()
>
> where alloc() is an allocation + initialization, and
>
> register() -> unregister()
>
> where register() is initialization + add() and
> unregister() is del() + put().

I wasn't sure if it'd help to adopt the driver model's naming, but I
guess it just might do, so I'll do that.

Thanks!
