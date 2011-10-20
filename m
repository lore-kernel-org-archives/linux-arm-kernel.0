From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Thu, 20 Oct 2011 15:55:55 +0100
Subject: Update: ARM Sub-Architecture Maintainers workshop at Kernel Summit
	2011
In-Reply-To: <20111020144641.GC6100@sirena.org.uk>
References: <CACxGe6vMLeHrN7jLB2=JYQON1ykOiWTeGiH8YXkUbguV0D-HEw@mail.gmail.com>
	<CACRpkdawG9aKAT7PHuYapiHexkteq-_seQGd6iRORyt-LwbmxA@mail.gmail.com>
	<4EA026C5.1050803@cam.ac.uk>
	<CAGsJ_4z+DWSXyn6gN9tOAqY3txM22Hk9jNZFPQ_TuYxT3RsRog@mail.gmail.com>
	<20111020144641.GC6100@sirena.org.uk>
Message-ID: <4EA0367B.7090300@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/11 15:46, Mark Brown wrote:
> On Thu, Oct 20, 2011 at 10:25:15PM +0800, Barry Song wrote:
> 
>> as Jonathan knows, i was one of main authors of those drivers in
>> drivers/staging/iio. one problem for iio is now most people still
>> write sensor drivers based on input subsystem or others but not iio.
>> and Android HAL or other frameworks prefer input _event as well.
>> so to push iio ahead, we might push related app ahead too.
> 
> Well, that's not entirely clear - one of the reasons for discussing an
> in kernel API is so that drivers for these subsystems can make use of
> IIO channels.  Another big blocker for deployment of IIO right now is
> that it's in staging, fixing that will probably help enormously.
That and push in kernel APIs.  Working on that though.  Note however they
will be dependent on at least the first three sets of patches in
our original master move out of staging plan.  So lots of other stuff
to get fixed up first.  Some of which is probably going to be controversial.

Direct user space code will exist for the usecases we were originally
targeting, but where it makes sense, Mark has convinced me of the need
to push things out through input / hmwon. Guenter doesn't seem against
so that's a start.  Dmitry has always pushed for this (though last
time we talked about it, plan was a userspace bridge).

We'll still want to be very careful to keep any users that go into
mainline on the straight an narrow wrt to pushing stuff through those
subsystems that doesn't belong.

Jonathan
