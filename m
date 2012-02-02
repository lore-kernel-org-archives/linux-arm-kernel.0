From: khilman@ti.com (Kevin Hilman)
Date: Thu, 02 Feb 2012 14:20:26 -0800
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <20120202190708.GE2518@linux.vnet.ibm.com> (Paul E. McKenney's
 message of "Thu, 2 Feb 2012 11:07:08 -0800")
References: <20120202004253.GA10946@linux.vnet.ibm.com>
 <1328143404-11038-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1328143404-11038-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com>
Message-ID: <87obtgc1xx.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:

[...]

>> > The two options I see are:
>> > 
>> > 1.	Rip tracing out of the inner idle loops and everything that
>> > 	they invoke.
>> 
>> What I suggested above.  But as I said I know sh*t about that tracing 
>> implementation so that's an easy suggestion for me to make.
>
> Works for me as well.  ;-)

While I must admit not having a better suggestion, I for one would vote
strongly against removing tracing from the idle path.

Being a PM developer and maintainer, much of the code I work on and
maintain happens to be run in the bowels of the idle path.  Not having
the ability to trace this code would be a major step backwards IMO.

Kevin
