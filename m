From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 28 Jun 2011 14:28:57 -0400 (EDT)
Subject: [PATCH 0/3] Add generic idle notifiers
In-Reply-To: <BANLkTi=1ZfWfDpUkSV0f1KoWmkJbxHg=_w@mail.gmail.com>
References: <1309229190-25006-1-git-send-email-toddpoynor@google.com>
	<BANLkTi=1ZfWfDpUkSV0f1KoWmkJbxHg=_w@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1106281425340.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jun 2011, Bryan Wu wrote:

> On Tue, Jun 28, 2011 at 10:46 AM, Todd Poynor <toddpoynor@google.com> wrote:
> > Add notifiers for idle entry and exit, called with IDLE_START when a
> > CPU goes idle and IDLE_END when it goes out of idle, based on the
> > existing idle notifiers for the x86_64 arch.
> >
> > Convert x86_64 to use these notifiers, and call the notifiers on ARM.
> >
> > Convert the ARM LEDs events for idle start/end to these notifiers.
> >
> 
> LinusW and I is working on consolidation LED events interface in ARM.
> Please take a look at https://patchwork.kernel.org/patch/918792/

There is no conflict between those two series as one deals with the way 
the LED events are generated and the other with the way those events are 
acted upon.  The LED event mechanism in the middle is still untouched 
(could be deprecated eventually when all its users have migrated to the 
common LED API but not yet).


Nicolas
