From: richard.weinberger@gmail.com (Richard Weinberger)
Date: Wed, 3 Aug 2016 10:30:16 +0200
Subject: Please don't replace numeric parameter like 0444 with macro
In-Reply-To: <CALYGNiPg9eXYdX209n8wEd03fh4Q45QT4EmUGjrZs+DEz-Jp5A@mail.gmail.com>
References: <CA+55aFw5v23T-zvDZp-MmD_EYxF8WbafwwB59934FV7g21uMGQ@mail.gmail.com>
 <20160803004226.GF2356@ZenIV.linux.org.uk>
 <CALYGNiPg9eXYdX209n8wEd03fh4Q45QT4EmUGjrZs+DEz-Jp5A@mail.gmail.com>
Message-ID: <CAFLxGvx8jmO-G2HkoBagjttZUFz+nhO7mRSZZQZfX-JQdfLUyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 3, 2016 at 10:07 AM, Konstantin Khlebnikov <koct9i@gmail.com> wrote:
> On Wed, Aug 3, 2016 at 3:42 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Tue, Aug 02, 2016 at 04:58:29PM -0400, Linus Torvalds wrote:
>>> [ So I answered similarly to another patch, but I'll just re-iterate
>>> and change the subject line so that it stands out a bit from the
>>> millions of actual patches ]
>>>
>>> On Tue, Aug 2, 2016 at 1:42 PM, Pavel Machek <pavel@ucw.cz> wrote:
>>> >
>>> > Everyone knows what 0644 is, but noone can read S_IRUSR | S_IWUSR |
>>> > S_IRCRP | S_IROTH (*). Please don't do this.
>>>
>>> Absolutely. It's *much* easier to parse and understand the octal
>>> numbers, while the symbolic macro names are just random line noise and
>>> hard as hell to understand. You really have to think about it.
>>>
>>> So we should rather go the other way: convert existing bad symbolic
>>> permission bit macro use to just use the octal numbers.
>>>
>>> The symbolic names are good for the *other* bits (ie sticky bit, and
>>> the inode mode _type_ numbers etc), but for the permission bits, the
>>> symbolic names are just insane crap. Nobody sane should ever use them.
>>> Not in the kernel, not in user space.
>>
>> Except that you are inviting the mixes like S_IFDIR | 17 /* oops, should've
>> been 017, or do we spell it 0017? */ that way.  I certainly agree that this
>> patch series had been a huge pile of manure, but "let's convert it in other
>> direction" is inviting pretty much the same thing, with lovely potential for
>> typos, etc.
>
> We could add several macro with readable names for really used rwx
> combinations, like:
>
> #define KERN_SECRET_RO 0400
> #define KERN_SECRET_RW 0600
> #define KERN_SECRET_WO 0200
> #define KERN_SECRET_DIR 0500
>
> #define KERN_PUBLIC_RO 0444
> #define KERN_PUBLIC_RW 0644
> #define KERN_PUBLIC_DIR 0555
>
> #define KERN_UNSAFE_RW 0666
> #define KERN_UNSAFE_WO 0222
> #define KERN_UNSAFE_DIR 0777

Or just keep it as-is, everybody can read them.
Why do we have to hide all kind of numbers behind CPP macros?
Is this a thing these days?

-- 
Thanks,
//richard
