From: elenbert@gmail.com (Oleg Kutkov)
Date: Mon, 11 Oct 2010 14:52:04 +0300
Subject: Own syscall implementation
Message-ID: <AANLkTinkx11iDEh2HAagdaER9yShQKmh1oSbMgRHMyyo@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

My name is Oleg and i'm newbie in a arm-kernel.
I doing experiments with kernel and trying to add my own syscall.
What i'm done:
1. Added somewhere this code:

asmlinkage long sys_mycall(int call, unsigned long __user *args);

SYSCALL_DEFINE2(mycall, int, call, unsigned long __user *, args)
{
      unsigned long a[6];

   if (err = copy_from_user(a, args, nargs[call])) {
       return -EFAULT;
   }

       ///some cool work///
}

2. Added to calls.S my function (but i'm not really understand what this :( )

.long sys_mycall

3. And finally define in unistd.h:

#define __NR_mycall                    (__NR_SYSCALL_BASE+312)

Everything is good, but when some one calls me from userspace - i
receiving garbage in args and copy_from_user is failed to copy data...

What's wrong with my code and what secrets i don't know ?
I think it something with alignment...

Thanks,
Oleg.
