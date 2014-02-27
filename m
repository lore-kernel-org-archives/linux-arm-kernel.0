From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 27 Feb 2014 10:04:42 -0500 (EST)
Subject: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using
 a macro
In-Reply-To: <CAPDyKFqCHXj-O5EwYLQXpfs5oko=Yfi_ZLmQwKVVW8AjUSUZfQ@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1402271002130.1150-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Feb 2014, Ulf Hansson wrote:

> > So the main question from v1 remains: why use a macro, and not a function?
> >
> 
> I am no big fan of macros, but in this case I thought it make sense.
> Using _a_ function would not be enough, since we would need three, one
> for each runtime PM callback (suspend, idle, resume), right?
> 
> I am happy to change to whatever you guys thinks best, I have no strong opinion.

A reasonable compromise would be to define the macro, and then use it 
in those three new functions (and nowhere else).

The existing rpm_idle, rpm_suspend, and rpm_resume routines should then 
be changed to use the new functions.  And of course, the new functions 
could be called directly by subsystems or PM domains.

Alan Stern
