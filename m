From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 22 Mar 2017 11:47:49 -0700
Subject: [PATCH v7 1/3] Input: max11801_ts: Add missing of_match_table
In-Reply-To: <20170322184421.GB2899@dtor-ws>
References: <1490180808-2856-1-git-send-email-jagan@openedev.com>
 <20170322183039.GA2899@dtor-ws>
 <CAMty3ZApz+GVkeoT4-75tiJcn6-CxkzdOrMcH7hjK1k2Ht=ZUQ@mail.gmail.com>
 <20170322184421.GB2899@dtor-ws>
Message-ID: <20170322184749.GC2899@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 11:44:21AM -0700, Dmitry Torokhov wrote:
> On Thu, Mar 23, 2017 at 12:05:17AM +0530, Jagan Teki wrote:
> > On Thu, Mar 23, 2017 at 12:00 AM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Wed, Mar 22, 2017 at 04:36:46PM +0530, Jagan Teki wrote:
> > >> From: Jagan Teki <jagan@amarulasolutions.com>
> > >>
> > >> Added missing of_match_table for max11801_ts driver with
> > >> compatible as "maxim,max11801_ts"
> > >>
> > >
> > > Why not "maxim,max11801"? Also, I think we'd need a binding document.
> > 
> > Compatibility purpose to make this is for touchscreen and few of other
> 
> Compatibility with what? The i2c id is "max11801" (without the "-ts").

Now that I looked at your 2/3 and 3/3 patches you use:

+&i2c1 {
+       max11801: touchscreen at 48 {
+               compatible = "maxim,max11801";
+               reg = <0x48>;
+               interrupt-parent = <&gpio3>;
+               interrupts = <31 2>;
+       };
+};

so the compatible you are adding to the driver is definitely wrong.

By the way, it would be nice if you used symbolic constants to express
interrupt trigger type.

Thanks.

-- 
Dmitry
