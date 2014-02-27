From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 27 Feb 2014 11:22:23 -0500 (EST)
Subject: [PATCH V2 1/8] PM / Runtime: Fetch runtime PM callbacks using
 a macro
In-Reply-To: <CAPDyKFrbhmqmu-0uqX_U18nKXuu2z5ueYXqaz4LOHy=ijecs1g@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1402271120280.888-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Feb 2014, Ulf Hansson wrote:

> > A reasonable compromise would be to define the macro, and then use it
> > in those three new functions (and nowhere else).
> 
> Okay, let me send a v3 that tries this approach then.
> 
> >
> > The existing rpm_idle, rpm_suspend, and rpm_resume routines should then
> > be changed to use the new functions.  And of course, the new functions
> > could be called directly by subsystems or PM domains.
> 
> Not sure we should export these functions as a part of this patchset.
> Would it not be preferred, to first see if there are any that needs
> it?

I don't understand.  V2 of the patchset exports 
pm_runtime_force_suspend and pm_runtime_force_resume.  Why wouldn't you 
want to export them in V3?

Alan Stern
