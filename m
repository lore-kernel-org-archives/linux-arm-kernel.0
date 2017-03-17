From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 17 Mar 2017 14:18:00 +0100 (CET)
Subject: Schedule affinity_notify work while migrating IRQs during hot plug
In-Reply-To: <559ce4c1fef10c45eab12f65c4e0f0d9@codeaurora.org>
References: <05102c455476941d37904f8c6f387452@codeaurora.org>
 <a5b146bd9a36dd7b4fe2bc36cbaadade@codeaurora.org>
 <alpine.DEB.2.20.1702271818370.4732@nanos>
 <36fe90bcca0a9c6283c4012412ed2924@codeaurora.org>
 <alpine.DEB.2.20.1703132047250.3712@nanos>
 <559ce4c1fef10c45eab12f65c4e0f0d9@codeaurora.org>
Message-ID: <alpine.DEB.2.20.1703171416060.3538@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 Mar 2017, Sodagudi Prasad wrote:
> On 2017-03-13 13:19, Thomas Gleixner wrote:
> > Can you actually see the difference between these functions? There is a
> > damned good reason WHY this calls irq_do_set_affinity().
> 
> Other option is that, adding an argument to irq_do_set_affinity() and queue
> work to notify when that new parameter set.  I have attached patch for the
> same.

Documentation/process/submitting-patches.rst: Section #6
