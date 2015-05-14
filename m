From: mike.turquette@linaro.org (Michael Turquette)
Date: Wed, 13 May 2015 17:32:01 -0700
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150513110357.GD3066@sirena.org.uk>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
 <20150513110357.GD3066@sirena.org.uk>
Message-ID: <20150514003201.20636.83883@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Mark Brown (2015-05-13 04:03:57)
> On Wed, May 13, 2015 at 02:25:28PM +0530, Viresh Kumar wrote:
> > On 12-05-15, 14:42, Michael Turquette wrote:
> > > Quoting Viresh Kumar (2015-04-30 05:07:59)
> > 
> > > Why should this new binding exist?
> 
> > The answer to this particular query is perhaps simple, i.e. we have
> > unsolved problems that we wanted to solve in a generic way.
> 
> > But probably the bigger question is "Should we really put the OPPs
> > (new or old bindings) in DT".
> 
> And also is trying to do this in a completely generic manner the right
> way of going about things - do we really understand the problem area
> well enough to create a completely generic solution for all cases,
> bearing in mind that once things go into a DT binding they become an ABI?

No, we don't understand the problem space well enough to form an ABI.
And even if we did understand it perfectly today, the constraints and
expressions will change tomorrow.

Putting this stuff in C without any philosophical constraints on whether
or not we can change it later is the way to go.

Regards,
Mike
