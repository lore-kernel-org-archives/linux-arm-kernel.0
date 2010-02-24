From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 24 Feb 2010 13:59:53 +0100
Subject: QUERY: Inclusion of header files in kernel header files.
In-Reply-To: <22dbbef21002232020k76d0f737tf24c8cba29679a21@mail.gmail.com>
References: <22dbbef21002222230x780c1ffatca5541453f6043ab@mail.gmail.com>
	<f17812d71002231852l1e47add7pc17764c67d26ae2b@mail.gmail.com>
	<22dbbef21002232020k76d0f737tf24c8cba29679a21@mail.gmail.com>
Message-ID: <201002241359.55543.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On Wednesday 24 February 2010 05:20:59 viresh kumar wrote:
> > My understanding is that if you are going to include every dependency
> > into the header files, they are going to explode very soon. E.g. like
> > bus.h, as long as you declared something like:
> > 
> > struct device;
> > struct resource;
> 
> If these two structure prototypes are already present in latest kernel
> then its okay.
> Actually i have seen 2.6.32 and these prototypes are not present
> there, so we may need to add header file or add prototypes of these
> structures.

As a rule of thumb, header files should use forward-declaration of structures 
whenever possible. Including other header files to pull in structure 
definitions is only required when embedding a structure into another (as the 
compiler needs to known the embedded structure size) and when inline functions 
or macros dereference pointers to the structure (although in the case of 
macros there's not strict requirement).

Exceptions to this rule are of course permitted.

-- 
Regards,

Laurent Pinchart
