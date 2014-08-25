From: jdl@jdl.com (Jon Loeliger)
Date: Mon, 25 Aug 2014 08:08:59 -0500
Subject: [RFC PATCH 0/9] dt: dependencies (for deterministic driver
 initialization order based on the DT)
In-Reply-To: <20140825093931.GB2399@ulmo>
References: <1399913280-6915-1-git-send-email-holler@ahsoftware.de>
 <20140514141914.446F7C4153D@trevor.secretlab.ca>
 <20140821140211.GD19293@ulmo.nvidia.com> <53F64624.5000403@ahsoftware.de>
 <20140822131919.GX21734@leverpostej> <20140825093931.GB2399@ulmo>
Message-ID: <E1XLu15-0002DP-6o@jdl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 

> Anyway, instead of going back and forth between "deferred probe is good"
> and "deferred probe is bad", how about we do something useful now and
> concentrate on how to make use of the information we have in DT with the
> goal to reduce the number of cases where deferred probing is required?

Good idea.

The proposal on the table is to allow the probe code
to make a topological sort of the devices based on
dependency information either implied, explicitly stated
or both.  That is likely a fundamentally correct approach.

I believe some of the issues that need to be resolved are:

    1) What constitutes a dependency?
    2) How is that dependency expressed?
    3) How do we add missing dependencies?
    4) Backward compatability problems.

There are other questions, of course.  Is it a topsort
per bus?  Are there required "early devices"?  Should
the inter-node dependencies be expressed at each node,
or in a separate hierarchy within the DTS?  Others.

HTH,
jdl
