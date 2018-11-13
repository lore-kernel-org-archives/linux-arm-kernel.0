From: wpdster@gmail.com (Patrick Doyle)
Date: Tue, 13 Nov 2018 13:21:06 -0500
Subject: Weird OOM problem
In-Reply-To: <CAF_dkJB-Z-jU3O95PrE_ToFcOTNdEqMLnPOkzPwBZZfnjyUQwQ@mail.gmail.com>
References: <CAF_dkJB-Z-jU3O95PrE_ToFcOTNdEqMLnPOkzPwBZZfnjyUQwQ@mail.gmail.com>
Message-ID: <CAF_dkJBM34ZJh5GyPtLo3L0cLO9ogiWhWe-1yyGcUeYRyhv_aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Closing the loop on this in case anybody else runs into a similar
problem someday (and doesn't want to spend 6 days trying to figure out
what is going on).

My kernel was configured with FORCE_MAX_ZONEORDER=15, which, as I
understand things, means that the kernel would attempt (be required?)
to keep blocks of 16K (2^14) pages available to be allocated in
contiguous chunks.  With 128M of RAM, I only have 32K physical pages
of memory available.  Apparently when the contents of my tmpfs grew
beyond 32M (8K pages), the kernel decided it needed to do some
housekeeping in order to ensure that it could provide a 16Kpage chunk
of memory, should anybody ask for one.  That led to the OOM killer.

That's my explanation and I'm sticking to it... until somebody
educates me as to the real cause of my problem.  All I know is that
when I changed FORCE_MAX_ZONEORDER back to its default value of 11, I
could use more space in my tmpfs and all was good again.

--wpd
