From: dianders@chromium.org (Doug Anderson)
Date: Thu, 11 Sep 2014 15:54:55 -0700
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <20140911180322.GP4015@sirena.org.uk>
References: <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <CAD=FV=VAqzvJQDQMjjeQ1p5okyDzE=ff_sguObZxh59qbzcaTQ@mail.gmail.com>
 <CACxGe6t_ex1bU=CvTpXR4VJgNf1hAq33hr6ykbHy_sMXEk4h-g@mail.gmail.com>
 <CAOesGMipX3MV6sMWLuY=D+bQ6qe8P17YFbTFwZOHPeSc3Pw9Cg@mail.gmail.com>
 <20140910143144.GF7960@sirena.org.uk>
 <CACxGe6u=QkGTKGfaE_jJ5VFMhdVKQNggp3qVBUgNP7rDbZss_A@mail.gmail.com>
 <20140910153919.GH7960@sirena.org.uk>
 <CACxGe6uBcTPMh4p=oi7m_TVpjUrkgbQvxbStAn27HXEJxYe5fw@mail.gmail.com>
 <20140910165723.GK7960@sirena.org.uk>
 <20140911092233.CBC5CC40738@trevor.secretlab.ca>
 <20140911180322.GP4015@sirena.org.uk>
Message-ID: <CAD=FV=Vg-c6NyV5h2K-=UCU4dRyhQM-muH8T_VD2ULQFH=uzmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 11, 2014 at 11:03 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Sep 11, 2014 at 10:22:32AM +0100, Grant Likely wrote:
>> On Wed, 10 Sep 2014 17:57:23 +0100, Mark Brown <broonie@kernel.org> wrote:
>
>> > It's not quite as simple as just disabling PM - for example in the
>> > clocks case we've also got to worry about what happens with rate changes
>> > (which is going to get more and more risky as we get smarter about being
>> > able to push configuration changes back up the tree), regulators have a
>> > similar thing with voltage changes.  With simple enables and disables we
>> > have to worry about things like handling users who actively want to
>> > power things on and and off but may potentially be sharing a resource
>> > with an undeclared dependency.
>
>> I think we can be okay with the above. This is a best-effort situation
>> where we don't want to tear down how firmware has set up the board if
>> it can be reasonably assumed that something depends on it (simplefb).
>> However, if clocks or regulators are shared with other devices and those
>> drivers ask for other settings, then there is simply no recourse. In
>> that situation there must be a driver for the video device that takes
>> care of any constraints.
>
> When things break I'm not sure that users are going to understand that
> something that used to work for them was only provided on a best effort
> basis, I think they will expect things to carry on working.

Right.  This is exactly what happened at the start of this thread.
SimpleFB was working only on a best effort basis and then it stopped
working.  I agree that's pretty non-ideal.

-Doug
