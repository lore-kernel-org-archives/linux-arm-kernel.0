From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 11 Oct 2012 11:16:16 +0100
Subject: alignment faults in 3.6
In-Reply-To: <yw1xpq4ppcju.fsf@unicorn.mansr.com>
References: <506E1762.3010601@gmail.com><CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com><CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com><506E3E58.80703@gmail.com><CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com><20121005071216.GD4625@n2100.arm.linux.org.uk><CAG5Tg6VciuxJ=k+fatzLugcehF54mGNOLHpUwdMX99oCnAVg8Q@mail.gmail.com><20121005082439.GF4625@n2100.arm.linux.org.uk><506ED18C.3010009@gmail.com><20121005140556.GQ4625@n2100.arm.linux.org.uk><506EEFBB.3060705@gmail.com>
 <507619FA.6080001@jonmasters.org><yw1xtxu1pwtv.fsf@unicorn.mansr.com><AE90C24D6B3A694183C094C60CF0A2F6026B7038@saturn3.aculab.com>
 <yw1xpq4ppcju.fsf@unicorn.mansr.com>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B703B@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > It might be enough to use __attribute__((aligned(2))) on some structure
> > members (actually does 'ldm' need 8 byte alignment?? - in which case
> > aligned(4) is enough).
> 
> The aligned attribute can only increase alignment.

Not true.
If you have:

struct foo {
    short   a;
    int     b __attribute__((aligned(2)));
    short   c;
};

You'll find sizeof (struct foo) is 8, and that, on arm/sparc etc,
gcc will generate 2 16bit accesses (and shifts) for foo.b;

	David
