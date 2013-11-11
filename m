From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 11 Nov 2013 09:01:04 +0100
Subject: kernel BUG at kernel/kallsyms.c:222!
In-Reply-To: <CAFRkauBYUq3UAjqLvkuDVEz5BVyDpC0DuVRGTe4K+kcoCX17GA@mail.gmail.com>
References: <CACVXFVO=QA-R1+twCL9fc_3vASg6Ap-3ezi=tU1MV1pdPYrfWw@mail.gmail.com>
 <CAFRkauAdR3=ByE0_B3OsqOBjmbz2a02EXb+6g-vn=1TJ7AZc8Q@mail.gmail.com>
 <CACVXFVMaLOfDvzdn_1NryQY59cgtLdMMqHL-_ZAa95MPz4p56Q@mail.gmail.com>
 <CAFRkauDe7V3N0AbfvE_=GEXHZ_Fw62VsA8p50wSUYE1-TRqMfw@mail.gmail.com>
 <87zjpf4w0j.fsf@rustcorp.com.au>
 <CACVXFVNHryPXy2NQhPwXkoCeLUXQSgrWmgBkMNtGD_=X_62_5Q@mail.gmail.com>
 <CAFRkauDGiy3yZOwKFWMEJvYUe0OoXMEZHKaxogZHdgzMxexdHA@mail.gmail.com>
 <CACVXFVMAnewCkSNNke3kf1-yO+JCc_HBRp8iaLBPJ+14G79Haw@mail.gmail.com>
 <87y54vzszo.fsf@rustcorp.com.au>
 <CAFRkauBYUq3UAjqLvkuDVEz5BVyDpC0DuVRGTe4K+kcoCX17GA@mail.gmail.com>
Message-ID: <20131111080104.GH14892@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 11, 2013 at 02:43:28PM +0800, Axel Lin wrote:
> 2013/11/11 Rusty Russell <rusty@rustcorp.com.au>:
> > Ming Lei <tom.leiming@gmail.com> writes:
> I don't have other noMMU platform to test.
> But I think this issue impacts various !CONFIG_MMU platforms:
> We have CONFIG_PAGE_OFFSET=0xC0000000 in various default configs.
> For !CONFIG_MMU case, it just don't use the CONFIG_PAGE_OFFSET setting.
> So use CONFIG_PAGE_OFFSET to filter symbols looks wrong to me for all
> !CONFIG_MMU cases.
I don't know what the original problem is, but for my Cortex-M3 machine
(ie. !MMU) I also have CONFIG_PAGE_OFFSET=0xC0000000. Didn't see this
resulting in any problems although the value looks bogus. (The range
0x90000000-0xdfffffff is reserved on my SoC. Trying to read from there
with the debugger fails with a message "Could not read memory.")

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
